# Panoptic_Widgets


## Adding Support for PDF Viewer

Add the following to your `web/index.html`

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.11.338/pdf.min.js"></script>
<script type="text/javascript">
   pdfjsLib.GlobalWorkerOptions.workerSrc = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.11.338/pdf.worker.min.js";
</script>
```