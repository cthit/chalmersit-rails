/*$("#page_documents").change(updateFileUrls);
$("#page_title").change(updateFileUrls);
function convertToSlug(Text)
{
    return Text
        .toLowerCase()
        .replace(/[^\w ]+/g,'')
        .replace(/ +/g,'-')
        ;
}

function updateFileUrls(){
  var element = document.getElementById("page_documents");
  var fileList = element.files;
  var ul = document.getElementById("list-document-urls");
  var trans = I18n.t("activerecord.attributes.post.title");
  $('.document-url').remove()
  for(var i=0,file;file=fileList[i];i++) {
      var li = document.createElement("li");
      var slug = convertToSlug(document.getElementById("page_title").value);
      var outString = "["+trans+"](http://"+window.location.host+"/uploads/page/documents/"+ slug +"/"+file.name+")";
      li.appendChild(document.createTextNode(outString));
      li.className += "document-url";
      ul.appendChild(li);
  }
}
*/
