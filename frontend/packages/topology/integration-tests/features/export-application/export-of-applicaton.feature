@topology
Feature: Export of application
              As a user, I have an unmanaged application which I want to export. I'd like to be able to later add that code to git or some shared location so that I can share with others, or import into a new cluster or same cluster but different project, or be able to apply updates to an existing application.



    #The operator mentioned below needs to be installed beforehand due to the issue in its installation
        Background:
            # Given user has installed Gitops primer Operator
              And user is at developer perspective
              And user has created or selected namespace "aut-export-application"


#marking below test as broken due to intermittent issue of not getting toast notification after export is complete
        @smoke @broken-test
        Scenario: Export application button in topology: EA-02-TC01
            Given user has created a deployment workload "nodejs-ex-git-1"
             When user navigates to Topology page
              And user clicks on Export Application button
             Then user can see a toast message saying "Export of resources in aut-export-application has started."
              And user can see a toast message saying "All the resources are exported successfully from aut-export-application. Click below to download it." and close it
              And user can see primer job created in topology


        @regression @odc-6296
        Scenario: Export Application modal when export application is in progress: EA-02-TC02
            Given user has created a deployment workload "nodejs-ex-git-2"
              And user is at Topology page
             When user clicks on Export Application button
              And user clicks on Export Application button again
             Then user can see "View logs" link, "Cancel Export", "Restart Export", and "Ok" button
              # And user can see a toast message saying "All the resources are exported successfully from aut-export-application. Click below to download it." and close it
#commented above line due to intermittent issue of not getting toast notification after export is complete


        @regression @manual @odc-6296
        Scenario: View logs when export application is in progress: EA-02-TC03
            Given user is at Topology page
              And Export Application has already started
             When user clicks on Export Application button again
              And user clicks on View logs link
             Then user can see page showing the Pod log tab


        @regression @broken-test
        Scenario: Restart Export when export application is in progress: EA-02-TC04
            Given user is at Topology page
              And Export Application has already started
             When user clicks on Export Application button again
              And user clicks on Restart button
             Then user can see a toast message saying "Export of resources in aut-export-application has started."
              And user can see a toast message saying "All the resources are exported successfully from aut-export-application. Click below to download it." and close it


        @regression @broken-test
        Scenario: Cancel Export when export application is in progress: EA-02-TC05
            Given user is at Topology page
              And Export Application has already started
             When user clicks on Export Application button again
              And user clicks on Cancel button
             Then user can see primer job gets deleted in topology


        @regression
        Scenario: Export application button in empty topology view: EA-02-TC06
            Given user has created or selected namespace "aut-export-applicatio-temp"
             When user navigates to Topology page
             Then user can see Export Application button disabled


        @regression @manual
        Scenario: Export Application is created: EA-02-TC07
            Given user is at Topology page
              And Export Application is completed
             Then user can see a toast message on export completion along with a link to download
              And user can see a deployment workload for primer is created


        @regression @manual
        Scenario: Download the exported application: EA-02-TC08
            Given user is at Topology page
              And Export Application is completed
              And user clicks on download button from the toast message
              And user clicks on "Log in with openshift" on the primer linked
              And user clicks on "Allow selected permissions" on Authorize page
             Then user can see a zip file is downloaded having the required file
