z<%inherit file="base.mako"/>
<%def name="title()">Dashboard</%def>
<%def name="content()">

##<%include file="modal_ob_register_project.mako"/>


<link rel="stylesheet" href="/static/css/typeahead.css">
<link rel="stylesheet" href="/static/css/onboarding.css">

<div class="row">
    <div class="col-md-6">
        <div class="page-header">
            <div class="pull-right"><a class="btn btn-default" href="/project/new">New Project</a></div>
            <h3>Projects</h3>
        </div>
        <div mod-meta='{
                 "tpl": "util/render_nodes.mako",
                 "uri": "/api/v1/dashboard/get_nodes/",
                 "replace": true
            }'></div>
    </div>
    <div class="row">
        <div class="col-md-6">
           <div id="watchFeed">
               <div class="page-header">


########################################################################################################################
                    <h3>I want to...</h3>
                        <div id="logScope">
                        </div><!-- end #logScope -->
                </div><!-- end #page-header -->
                <ul>

                    <!-- start #ob-newProject -->
                    <li id="obNewProject" class="ob-list list-group-item">
                        <div id="obNewProjectBtn" class="ob-reveal-btn">
                            <div class="ob-heading" >Create a New Project</div>
                            <img class="ob-expand-icon" id="obIconNewProject" src="/static/img/plus.png">
                        </div><!-- end #ob-newProject-btn -->
                        <div class="ob-reveal" id="obRevealNewProject">
                            <br> 
                            <%include file="project/new_project_form.mako"/>
                        </div> <!-- end #ob-reveal -->
                    </li> <!-- end #ob-newProject" -->

                    <!-- start #obRegisterProject -->
                    <li id="obRegisterProject" class="ob-list list-group-item"> 
                        <div id="obRegisterProjectBtn">
                            <div class="ob-heading" >Register a Project</div>
                            <img class="ob-expand-icon" id="obIconRegisterProject" src="/static/img/plus.png">
                        </div><!-- end #obInputProject-btn -->
                            <div class="ob-reveal" id="obRevealRegisterProject">
                        <div  id="projectSearchProjectRegisterProject">
                            <div>
                                
                        <div>
                            <img class="clear-button ob-reveal" id="clearInputProjectRegisterProject" src="/static/img/close2.png">
                            <input class="typeahead" type="text" placeholder="Search projects" id = 'inputProjectRegisterProject'>
                        </div>
                                
                            <span class="findBtn btn btn-default" id="addLinkRegisterProject" disabled="disabled">Go to registration page</span>
                        </div>
                    </div>
                    </li> <!-- end #obInputProject" -->

                    <!-- start #ob-AddFile -->
                    <li class="ob-list list-group-item">

                        <div class="row" >
                            <div class="col-md-12">
                                <h3>Add a File to a Project</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h4>1. Drop File (or click)</h4>
                                <div id="obDropzone" class="ob-dropzone-box pull-left"></div>
                                <div id="obDropzoneSelected" class="ob-dropzone-box ob-reveal pull-left">
                                    <img id="uploadIcon" src="//:0">
                                    <div id="obDropzoneFilename"></div>
                                    <progress class="ob-reveal" id="uploadProgress" max="100" value="0"></progress>
                                    <img class="clear-button" id="clearDropzone" src="/static/img/close2.png">
                                </div>
                            </div>
                        </div>
                        <div class="" id="obDropzoneReveal">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4> 2. Select a project</h4>
                                    <div style="position:relative;" class="projectSearchAddFile" >
                                        <img class="clear-button ob-reveal" id="clearInputProjectAddFile" src="/static/img/close2.png">
                                        <input class="typeahead search-box-add-file" type="text" placeholder="Type to search"
                                         id='inputProjectAddFile'>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h4>3. (optional) Select a component</h4>
                                    <div style="position:relative;" class="projectSearchAddFile">
                                        <img class="clear-button ob-reveal" id="clearInputComponentAddFile" src="/static/img/close2.png">                        
                                        <input class="typeahead search-box-add-file disabled-input" disabled="disabled" type="text" placeholder="Type to search" id='inputComponentAddFile'>
                                    </div>
                                    <span class="findBtn btn btn-default pull-right" id="addLinkAddFile" disabled="disabled">Upload</span>
                                </div>
                            </div>
                        </div>
                    </li> <!-- end #ob-AddFile" -->
                </ul>
#########################################################################################################################
            </div><!-- end #watchFeed -->
        </div>
    </div>
</div>
%if 'badges' in addons_enabled:
    <div class="row">
        <div class="col-md-6">
            <div class="page-header">
              <button class="btn btn-success pull-right" id="newBadge" type="button">New Badge</button>
                <h3>Your Badges</h3>
            </div>
            <div mod-meta='{
                     "tpl": "../addons/badges/templates/dashboard_badges.mako",
                     "uri": "/api/v1/dashboard/get_badges/",
                     "replace": true
                }'></div>
        </div>
        <div class="col-md-6">
            <div class="page-header">
                <h3>Badges You've Awarded</h3>
            </div>
            <div mod-meta='{
                     "tpl": "../addons/badges/templates/dashboard_assertions.mako",
                     "uri": "/api/v1/dashboard/get_assertions/",
                     "replace": true
                }'></div>
        </div>
    </div>
%endif
</%def>


<!-- this doesn't belong here -->

<%def name="javascript_bottom()">
<script>
// new project js
    $('#obNewProjectBtn').one("click", obOpenNewProject);

    function obOpenNewProject() {
        $('#obRevealNewProject').fadeIn(300);
        $(this).one("click", obCloseNewProject);
        $('#obIconNewProject').attr('src', "/static/img/minus.png")
    }

    function obCloseNewProject() {
        $('#obRevealNewProject').fadeOut(100);
        $(this).one("click", obOpenNewProject);
        $('#obIconNewProject').attr('src', "/static/img/plus.png")
    }

// TODO(sloria): require('jquery') here
//block the create new project button when the form is submitted
    $('#projectForm').on('submit',function(){
        $('button[type="submit"]', this)
            .attr('disabled', 'disabled')
            .text('Creating');
    });

// new registration js
    $('#obRegisterProjectBtn').one("click", obOpenRegisterProject);

    function obOpenRegisterProject() {
        $('#obRevealRegisterProject').fadeIn(300);
        $(this).one("click", obCloseRegisterProject);
        $('#obIconRegisterProject').attr('src', "/static/img/minus.png")
    }

    function obCloseRegisterProject() {
        $('#obRevealRegisterProject').fadeOut(100);
        $(this).one("click", obOpenRegisterProject);
        $('#obIconRegisterProject').attr('src', "/static/img/plus.png")
    }


    // Initialize the LogFeed
    $script(['/static/js/logFeed.js']);
    $script.ready('logFeed', function() {
        var logFeed = new LogFeed("#logScope", "/api/v1/watched/logs/");
    });
    // $script(['/static/vendor/dropzone/dropzone.js'],'dropzone');

    $script(['/static/js/typeahead.js'],'typeahead');
    $script(['/static/js/typeaheadSearch.js'], 'typeaheadSearch');
    
    $script(['/static/js/obAddFile.js']);
    $script.ready('obAddFile', function() {
        var obaddfile = new ObAddFile();
    });
    $script(['/static/js/obNewProject.js']);
    $script(['/static/js/obRegisterProject.js']);
    $script.ready('obRegisterProject', function() {
        var obregisterproject = new ObRegisterProject();
    });

    

</script>
</%def>
