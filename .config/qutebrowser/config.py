import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
c.url.default_page = 'www.google.com'

c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}','gh': 'https://github.com/search?q={}' }


#bindings
config.bind('eo','hint all right-click')


