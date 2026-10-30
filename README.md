# Anamika & Santosh: Wedding Invitation

This folder puts the animated invitation online for free with GitHub Pages.
Guests open one link in Safari or any other browser. Nothing to install.

Your GitHub repository must be **Public** (free Pages need that).

## Way 1: no commands (easiest)

1. Sign in at github.com. Click **New repository**.
2. Name it `anamika-santosh-wedding`, choose **Public**, click **Create repository**.
3. Click **uploading an existing file**. Drag in **only `index.html`**. Click **Commit changes**.
4. Open **Settings > Pages**. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
   Choose branch **main** and folder **/ (root)**. Click **Save**.
5. Wait 1 to 2 minutes and refresh. The address appears at the top:
   `https://YOUR-USERNAME.github.io/anamika-santosh-wedding/`
6. Open that address in Safari on your iPhone. Tap the envelope.

Do not upload the `.github` folder or `publish.sh` for this way.

## Way 2: one command (automatic)

You need `git` and the GitHub CLI (`gh`). On Windows, use Git Bash.

1. Run `gh auth login` once and follow the steps.
2. In this folder, run:

       bash publish.sh

3. It creates the repository, turns on Pages, deploys the invitation and prints your link.

After that, every time you change `index.html` and push to `main`, `.github/workflows/deploy.yml`
puts the new version online by itself.

## Notes

- Share the **link** with guests on WhatsApp. Do not send the `index.html` file. An iPhone shows files as a static preview.
- The page is public. Anyone with the link can see it, including the WhatsApp number used for RSVP replies.
- To change a time, venue or photo, ask Claude for a new `index.html`, then replace the file in the repository.
