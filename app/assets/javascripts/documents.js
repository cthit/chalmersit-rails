$(".document-input").change(documentsChanged);
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
function documentsChanged(){
  $("#addFile").show();
  updateFileUrls();
}
function updateFileUrls(){
  var div = document.getElementById("documents_container");
  var elements = div.getElementsByTagName("input");
  var fileList = []
  for (var i = 0; i < elements.length; i += 1) {
    for (var j = 0; j < elements[i].files.length; j += 1) {
      fileList.push(elements[i].files[j]);
    }
  }

  var ul = document.getElementById("list-document-urls");
  var trans = I18n.t("activerecord.attributes.post.title");
  $('.document-url').remove()
  if(document.getElementById("post_title_en") != null){
    var slug = convertToSlug(document.getElementById("post_title_en").value);
    var model = "post";
  }else if (document.getElementById("page_title") != null) {
    var slug = convertToSlug(document.getElementById("page_title").value);
    var model = "page";
  }
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
  <input type="file" name="document[]" class="document-input" multiple="multiple"/>
  <button type="button" onclick="removeFile(this);">X</button>
  `;
  $("#documents_container").append(element);
  $(".document-input").change(documentsChanged);
}
function removeFile(element){
  $(element).prev().value = "";
  $(element).prev().remove();
  $(element).remove();
  updateFileUrls();
}
