require 'nokogiri'
require 'yaml'
require 'json'

# TASKS

task :run_web_tests do
  %W[prepare_for_run run_cucumber merge_junit_reports rerun_if_needed generate_cucumber_json_reports final_clean_ups].each do |task_name|
    sh "rake #{task_name}" do
      #ignore errors
    end
  end
end

# Preparation tasks

desc 'This task creates required folders and files'
task :prepare_for_run do
  %W[create_folders create_files].each do |task_name|
    sh "rake #{task_name}" do
      #ignore errors
    end
  end
end

desc 'This task creates required folder tree for reporting'
task :create_folders do
  %W[artifacts artifacts/cucumber_json_reports artifacts/junit_xml_reports artifacts/final_test_reports].each do |dir_name|
    Dir.mkdir "#{dir_name}" unless Dir.exist?"#{dir_name}"
  end
end

desc 'This task creates and updates required files for reporting'
task :create_files do
  %W[artifacts/cucumber_json_reports/run.json artifacts/cucumber_json_reports/rerun.json artifacts/final_test_reports/final_cucumber_json_report.json].each do |file_name|
    File.open(file_name, 'w') do |file|
      file.puts '[]'
    end
  end
  File.open('artifacts/final_test_reports/final_junit_report.xml', 'w') do |file|
    xml_structure.each do |line|
      file.puts line
    end
  end
end

# Runner tasks

desc 'Run Cucumber features for the first run'
task :run_cucumber do
  sh "cucumber" do
    #ignore errors
  end
end

desc 'Rerun Cucumber features according to the fails.log'
task :rerun_failed do
  sh "cucumber @artifacts/final_test_reports/fails.log" do
    #ignore errors
  end
end

desc 'Rerun Cucumber features if there were failures in the first run'
task :rerun_if_needed do
  if File.file?("artifacts/final_test_reports/fails.log")
    if File.read("artifacts/final_test_reports/fails.log").empty?
      puts 'Rerun step skipped, no fails occurred during the first run'
    else
      fails = File.read("artifacts/final_test_reports/fails.log")

      File.open('artifacts/final_test_reports/fails.log', 'w') do |file|
        file.puts fails.gsub('\n', ' ')
      end

      sh "rake rerun_and_update_reports" do
        #ignore errors
      end
    end
  else
    puts 'Rerun step skipped, no fails occurred during the first run'
  end
end

desc 'Rerun failed Cucumber features and update respective reports'
task :rerun_and_update_reports do
  %W[clean_junit rerun_failed merge_junit_reports].each do |task_name|
    sh "rake #{task_name}" do
      #ignore errors
    end
  end
end

# Cleaning tasks
desc 'Cleaning interim JUnit reports'
task :clean_junit do
  catalog = 'artifacts/junit_xml_reports'
  files = Dir.entries(catalog).delete_if { |entry| File.directory?(entry) }
  files.map! { |f| "#{catalog}/#{f}" }
  rm files
end

desc 'Cleaning interim Cucumber JSON reports'
task :clean_cucumber_json do
  catalog = 'artifacts/cucumber_json_reports'
  files = Dir.entries(catalog).delete_if { |entry| File.directory?(entry) }
  files.map! { |f| "#{catalog}/#{f}" }
  rm files
end

desc 'Cleaning rudimentary folders'
task :clean_folders do
  catalog = 'artifacts'
  dirs = Dir.entries(catalog).drop 2
  dirs.delete('final_test_reports')
  dirs.map! { |f| "#{catalog}/#{f}" }
  dirs.each do |dir_path|
    remove_dir dir_path if Dir.exist?"#{dir_path}"
  end
end

desc 'Cleaning project tree from unnecessary files and folders'
task :final_clean_ups do
  %W[clean_junit clean_cucumber_json clean_folders].each do |task_name|
    sh "rake #{task_name}" do
      #ignore errors
    end
  end
end

# Report generation tasks

desc 'Merging interim JUnit reports to final JUnit report'
task :merge_junit_reports do
  file_names = Dir.entries('artifacts/junit_xml_reports').delete_if { |entry| File.directory?(entry) }
  file_names.each do |file_name|
    sh "junit_merge artifacts/junit_xml_reports/#{file_name} artifacts/final_test_reports/final_junit_report.xml" do
      #ignore errors
    end
  end
end

desc 'Merging interim Cucumber json reports to final Cucumber json report'
task :generate_cucumber_json_reports do
  test_results = []

  run_results = JSON.parse(File.read('artifacts/cucumber_json_reports/run.json'))
  rerun_results = JSON.parse(File.read('artifacts/cucumber_json_reports/rerun.json'))

  run_results.each do |x|
    rerun_results.each do |y|
      if y.values[0] == x.values[0]
        x.merge!(y)
      end
    end
    test_results.push(x)
  end

  File.open('artifacts/final_test_reports/final_cucumber_json_report.json', 'w') do |file|
    require 'json'
    file.puts test_results.to_json
  end
end

# METHODS

def xml_structure
  ['<?xml version="1.0" encoding="UTF-8"?>',
   '<testsuite name="" tests="" failures="" errors="" time="" timestamp="">',
   '  <!-- Randomized with seed 00000 -->',
   '  <properties/>',
   '</testsuite>']
end