class @QiniuUploader
  constructor: (opts) ->
    uploader = new Qiniu.uploader
      runtimes: "html5,html4" #上传模式,依次退化
      browse_button: opts.button #上传选择的点选按钮，**必需**
      uptoken_url: "/qiniu_token" #Ajax请求upToken的Url，**必需**（服务端提供）
      unique_names: true
      domain: "http://7xid9r.com1.z0.glb.clouddn.com/" #bucket 域名，下载资源时用到，**必需**
      # container: "container" #上传区域DOM ID，默认是browser_button的父元素
      max_file_size: "10mb" #最大文件体积限制
      flash_swf_url: "/uploader.swf" #引入flash,相对路径
      filters         : [
        {title : "图片文件", extensions : "jpg,gif,png,bmp,jpeg"}
      ]
      file_data_name  : 'file'

      max_retries: 3 #上传失败最大重试次数
      dragdrop: true #开启可拖曳上传
      drop_element: "container" #拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
      chunk_size: "4mb" #分块上传时，每片的体积
      auto_start: true #选择文件后自动上传，若关闭需要自己绑定事件触发上传
      init:

        #文件添加进队列后,处理相关的事情
        FilesAdded: (up, files) ->

        # 文件上传成功
        FileUploaded: (up, file, info) ->
          domain = up.getOption('domain')
          res = jQuery.parseJSON(info)
          link = domain + res.key + '-authenticates'
          $("##{opts.button}").parents('.dimmer').siblings('img').attr('src', link)
          $("##{opts.button}").parents('.dimmer').siblings('input').val(res.key)
