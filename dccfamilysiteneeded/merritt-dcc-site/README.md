# Merritt Family DCC page — free public hosting with auto-updating totals

This folder is a ready-to-upload website for **GitHub Pages** (free). A scheduled job runs **3 times a day** (about 7 AM, 1 PM and 7 PM Eastern), pulls each rider's raised amount and goal straight from the Dolphins Cancer Challenge site, and updates the progress rings and family total automatically.

## What's inside

| File | What it does |
|---|---|
| `index.html` | The full page (photos, carousel, cards, letter) |
| `data.json` | The latest totals. The page reads this every time someone opens it |
| `scripts/update-totals.sh` | Fetches the totals from the DCC site |
| `.github/workflows/update-totals.yml` | Runs that script 3× a day and saves the results |

## One-time setup (about 10 minutes)

1. **Create a free GitHub account** at github.com (use a personal email).
2. Click **+ → New repository**. Name it something like `merritt-dcc`. Choose **Public**. Click **Create repository**.
3. On the new repository page, click **uploading an existing file**. Drag in **everything inside this folder** — `index.html`, `data.json`, and the `scripts` and `.github` folders. Click **Commit changes**.
   - Tip: the `.github` folder is hidden on some computers. On Windows, turn on *View → Show → Hidden items* in File Explorer. If it still won't upload, create it on GitHub instead: **Add file → Create new file**, type `.github/workflows/update-totals.yml` as the name, and paste in the contents of that file.
4. **Turn on the website:** go to **Settings → Pages**. Under *Build and deployment*, set Source to **Deploy from a branch**, branch **main**, folder **/ (root)**. Click **Save**. After a minute, GitHub shows your public address, like `https://your-username.github.io/merritt-dcc/`.
5. **Allow the updater to save totals:** go to **Settings → Actions → General → Workflow permissions**, choose **Read and write permissions**, and click **Save**.
6. **Run it once now:** go to the **Actions** tab, click **Update fundraising totals → Run workflow**. In about a minute, `data.json` will show today's numbers, and so will the page.

That's it. From then on the totals refresh on their own three times a day. You can press **Run workflow** any time for an instant refresh.

## Good to know

- The page itself never contacts the DCC site from visitors' browsers. Only the scheduled job does, with a 16-second pause between riders to follow DonorDrive's request limit.
- GitHub pauses scheduled jobs on repositories with no activity for 60 days. The job's own updates count as activity whenever totals change; if donations are quiet for two months, GitHub will email you, and one click re-enables it.
- To change photos or wording later, replace `index.html` the same way (Add file → Upload files).
- If a rider's DCC ID ever changes, update the numbers in both `scripts/update-totals.sh` and the `RIDERS` list in `index.html`.
