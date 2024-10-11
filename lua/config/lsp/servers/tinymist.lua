local M = {}

M.filetypes = {
  "typst",
}

M.settings = {
  tinymist = {
    single_file_support = true,
    root_dir = function ()
      return vim.fn.getcwd()
    end,
    settings = {
      exportPdf = "onType",
      outputPath = "$root/target/$dir/$name",
      formatterMode = "typstyle"
    }
  }
}

return M
