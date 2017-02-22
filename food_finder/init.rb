###### Food Finder ######
#
# Launch this file from the command line to get started
#
#

APP_ROOT = File.dirname(__FILE__)

#require "#{APP_ROOT}/lib/guide"                 --> Informing a relative Path
#require File.join(APP_ROOT, 'lib', 'guide.rb')  --> Doing the same, but using the specific separator of the OS
#require File.join(APP_ROOT, 'lib', 'guide')     --> Doing the same, but omitting the extension of the File

$:.unshift( File.join(APP_ROOT, 'lib') )  #--> The variable $: receives an array informing the folders which the Ruby 
                                          #    must look for files
require 'guide'                           #--> So now we are able to inform only the name of the file, without the folders

guide = Guide.new("restaurants.txt")
guide.launch!