$(".document-input").change(updateFileUrls);
$("#post_title_en").change(updateFileUrls);
$("#page_title").change(updateFileUrls);
function convertToSlug(Text)
{
    return Text
        .toLowerCase()
        .replace(/[^\w ]+/g,'')
        .replace(/ +/g,'-')
        ;
}
$(document).ready(function () {
  try {
    trans = I18n.t("activerecord.attributes.post.title");
  } catch (e){
    trans = "Title";
  }
});
function updateFileUrls(){
  var div = document.getElementById("documents_container");
  var elements = div.getElementsByTagName("input");
  var fileList = []
  for (var i = 0; i < elements.length; i += 1) {
    for (var j = 0; j < elements[i].files.length; j += 1) {
      fileList.push(elements[i].files[j]);
    }
  }
  if(document.getElementById("post_title_en") != null){
    slug = convertToSlug(document.getElementById("post_title_en").value);
    model = "post";
  }else if (document.getElementById("page_title") != null) {
    slug = convertToSlug(document.getElementById("page_title").value);
    model = "page";
  }

  var ul = document.getElementById("list-document-urls");
  $('.document-url').remove()
  for(var i=0,file;file=fileList[i];i++) {
      var li = document.createElement("li");
      var outString = "["+trans+"](http://"+window.location.host+"/uploads/"+model+"/documents/"+ slug +"/"+file.name+")";
      li.appendChild(document.createTextNode(outString));
      li.className += "document-url";
      ul.appendChild(li);
  }
}
function addFileInput(){
  element = `
  <div class="documents-input-container">
    <input type="file" name="document[]" class="document-input" multiple="multiple"/>
    <ul class="button-group even-2">
      <li><button type="button" class="rem-file-button tiny"onclick="removeFile(this);"><i class="fa fa-minus-circle" aria-hidden="true"></i></button></li>
      <li><button type="button" class="ui-button tiny add-file-button" onclick="addFileInput();"><i class="fa fa-plus-circle" aria-hidden="true"></i></button></li>
    </ul>
  </div>
  `;
  $("#documents_container").append(element);
  $(".document-input").change(updateFileUrls);
}
function removeFile(element){
  $(element).parent().parent().parent().remove();
  updateFileUrls();
}
