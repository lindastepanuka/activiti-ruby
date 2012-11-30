require 'rest_client'
require 'uri'
require "active_support/core_ext"

module ActivitiRuby
  class Activiti
    def initialize(endpoint)
      @uri = endpoint+"/activiti-rest/service/"
    end

    def list_process
      RestClient.get @uri+'process-definitions'
    end

    def list_process_instances(process_key = nil)
      RestClient.get @uri+'process-instances'
    end

    def list_group_users(group)
      RestClient.get @uri+'groups/'+group+'/users'
    end

    def list_jobs
      RestClient.get @uri+'management/jobs'
    end

    def instanciate_process (process_key,user,group)
      RestClient.post @uri+'process-instance',  {'processDefinitionKey' => process_key, 'owner' => user}.to_json
    end

    def instance_informations(instance_id)
      RestClient.get @uri+'processInstance/'+instance_id
    end

    def login(user_id,password)
      RestClient.post @uri+'login',  {'userId' => user_id, 'password' => password}.to_json, :content_type => 'application/json'
    end

    def get_form(task_od)
      RestClient.get @uri+'form/'+task_id+'/properties'
    end

    def get_diagram(instance_id)
      RestClient.get @uri+'processInstance/'+instance_id+'/diagram'
    end

    def list_process_instance_tasks(process_instance_id)
      RestClient.get @uri+"process-instance/#{process_instance_id}/tasks"
    end

    def task_informations(task_id)
      RestClient.get @uri+'task/'+task_id
    end

    def perform_task(task_id, state, params)
      RestClient.put @uri+'task/'+task_id+'/'+state,  params.to_json
    end

    def tasks_summary(user_id)
      RestClient.get @uri+"tasks-summary?user=#{user_id}"
    end

    def task_list(user_id, assignment_type = "assignee")
      RestClient.get @uri+"tasks?#{assignment_type}=#{user_id}"
    end
  end
end
