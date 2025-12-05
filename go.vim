au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)

nnoremap <leader>. :call ftplugin#go#OpenTestAlternate()<cr>
