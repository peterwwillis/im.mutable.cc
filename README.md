# www.mutable.cc

## About

This is [my personal site / blog](https://mutable.cc/).

- CDN by CloudFlare
- Hosted on Google Pages
- Content edited & generated statically by [Lektor](https://www.getlektor.com/)
- Deployed with Google Actions


## Development / Editing Content

To edit content:

1. Install Git, Make, Docker
2. Check out this Git repo
3. Run `make docker-lektor-server` and wait for all the building to finish
4. Open a browser to [http://127.0.0.1:5000/](http://127.0.0.1:5000)
5. Browse and edit the site
   1. To create a new blog post,
      1. Go to the Blog page and click the pencil in the top righthand corner of the page
      2. On the new "Edit Blog" page, click "Add Page"
      3. Put in the title of the new blog entry and click "Add Child Page"
      4. Fill out the Title, Date, and Body, and click "Save Changes"


## Deployment / Publishing

To publish content:

1. Follow the above instructions to edit some content
2. Find the new files that have been created in [lektor/](./lektor/).
   1. `git add` any new files/directories
   2. `git commit -a`
   3. `git push`
3. The [GitHub Action deploy workflow](.github/workflows/deploy.yml) will take care of the rest
