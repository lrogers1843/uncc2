class Project < ApplicationRecord
    has_many :pictures
    accepts_nested_attributes_for :pictures
    
    def generate_kml
        content = []
        content.push('<?xml version="1.0" encoding="UTF-8"?>')
        content.push('<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">')
        content.push('<Document>')
        content.push("<name>#{self.id}.kmz</name>")
        #cycles through each picture in db for the current project
        self.pictures.each do |pic|
            pic_title = pic.image.to_s.split('/').last
            content.push('<Placemark>')
            content.push("<name>#{pic_title}</name>")
            content.push('<description>')
            content.push('<![CDATA[')
            line = '<img style="max-width:1000px;" src="' + '' + pic_title + '">' 
            content.push(line)
            content.push(']]>')
            content.push('</description>')
            content.push('<Point>')
            content.push("<coordinates>-#{pic.long},#{pic.lat}</coordinates>")
            content.push('</Point>')
            content.push('</Placemark>')
        end
        content.push('</Document>')
        content.push('</kml>')
        #pushes upload to S3 folder
        s3 = Aws::S3::Resource.new
        obj = s3.bucket(ENV['S3_BUCKET']).object("uploads/" + "#{self.id}" + "/doc.kml")
        File.open("kml_temp", "w+") { |f| 
        f.puts(content)
        obj.put(body: f)
        }
    end
    
    def generate_kmz
        #create
        directory_to_zip = "tmp/uploads/#{self.id}"
        output_file = "tmp/uploads/kmz_directory/#{self.id}.kmz"
        zf = ZipFileGenerator.new(directory_to_zip, output_file)
        zf.write()
        #send to S3
        s3 = Aws::S3::Resource.new
        obj = s3.bucket(ENV['S3_BUCKET']).object("uploads/kmz_directory/" + "#{self.id}.kmz")
        obj.upload_file("tmp/uploads/kmz_directory/#{self.id}.kmz")
    end
    
    def download_project
        #tmp cleanup    
        #FileUtils.rm_r '/tmp'
        
        #delete target directory if exists
        if Dir.exist?("tmp/uploads/#{self.id}") 
            FileUtils.remove_dir("tmp/uploads/#{self.id}")
        end
        
        #create kmz_dir if needed
        if Dir.exist?("tmp/uploads/kmz_directory") 
        else
           FileUtils.mkdir_p "tmp/uploads/kmz_directory"  
        end
        
        #create target dir
        FileUtils.mkdir_p "tmp/uploads/#{self.id}" 
        
        #download pics
        s3 = Aws::S3::Resource.new
        s3.bucket(ENV['S3_BUCKET']).object_versions({ prefix:"uploads/#{self.id}" }).each do |object|
            #get file name
            full_key = object.key
            file_name = full_key.to_s.split('/').last
            #save to /tmp
            object.get(response_target: "tmp/uploads/#{self.id}/#{file_name}")
        end
        
    end
    
    def cleanup
        FileUtils.rm_r Dir.glob('tmp/uploads/*')
    end
    
end
