class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def recieve
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      data = params.as_json
    end

    form_id = 1 #DSaPP 2017 App
    form = Form.find(form_id)
    form.num_records += 1
    form.save!
    resp = form.responses.create!(form_record_id: form.num_records)

    data.each do |tag, value|
      puts tag
      puts value
      if(tag == 'FieldStructure' || tag == 'FormStructure')
        next
      end

      subkey_num = tag
      field_key_entry = form.field_keys.find_by(form_id: form.id, subkey_num: subkey_num)
      if field_key_entry
        key_num = field_key_entry.key_num
        key_name = field_key_entry.key
        subkey_name = field_key_entry.subkey
      else
        expansion = expand_field_key_list(data['FieldStructure'], subkey_num)
        key_num = expansion[:key_num]
        key_name = expansion[:key_name]
        subkey_name = expansion[:subkey_name]
        if key_name #if a field number was found (i.e. the current pair isn't metadata)
          field_key_entry = form.field_keys.create(form_id: form.id,
                                            key_num: key_num,
                                            subkey_num: subkey_num,
                                            subkey: subkey_name,
                                            key: key_name)
        end
      end
      if field_key_entry #if the current pair represents a field in the form (and not metadata)

        resp_prop = resp.response_properties.find_by(key_num: key_num)
        if(!resp_prop) #If the key being examaned doesn't have an entry, create one
          resp_prop = resp.response_properties.new(form_id: form.id,
                                form_record_id: resp.form_record_id,
                                response_id: resp.id,
                                key_num: key_num,
                                key: key_name)
          resp_prop.save!
        end
        #Create a subkey entry associated with the key being examined
        resp_subprop = resp_prop.response_subproperties.new(subkey_num: subkey_num,
                                                            subkey: subkey_name,
                                                            value: value)
        resp_subprop.save!
      end
    end

    render nothing: true
  end

  def expand_field_key_list(field_structure, subkey_num)
    key_hash = {
      :key_name => nil,
      :key_num => nil,
      :subkey_name => nil
    }
    JSON.parse(field_structure).each do |subvalue|
      subvalue[1..-1].each do |subsubvalue|
        subsubvalue.each do |subsubsubvalue|
          if(subsubsubvalue['SubFields'] != nil) #If subfields exist
            subsubsubvalue['SubFields'].each do |subfield|
              if(subfield['ID'] == subkey_num)
                key_hash[:key_name] = "#{subsubsubvalue['Title']}"
                key_hash[:key_num] = "#{subsubsubvalue['ID']}"
                key_hash[:subkey_name] = "#{subfield['Label']}"
                return key_hash
              end
            end
          elsif (subsubsubvalue['ID'] == subkey_num) #'ID'
            key_hash[:key_name] = subsubsubvalue['Title'] #'Title'
            key_hash[:key_num] = subsubsubvalue['ID'] #
            #subkey_name currently not set, consider adding if necessary
            return key_hash
          end
        end
      end
    end
    return key_hash
  end
end
