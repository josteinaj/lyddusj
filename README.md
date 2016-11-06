# NLBs lyddusj

Installasjon
------------

- sett opp update-list.sh med crontab til å kjøre en gang i døgnet
- sett opp lyddusj.sh til å kjøre f.eks. en gang i minuttet

### Avhengigheter:

Jeg tror dette er alle avhengighetene (ikke 100% sikker):

```
sudo apt-get install curl wget sox libsox-fmt-mp3 libav-tools
```

Legg dette i crontab med rot-rettigheter (`sudo crontab -e`, tilpass stier hvis nøvendig):

```
* * * * * JINGLE=0 flock -n /var/run/lyddusj.lockfile -c /home/ubuntu/lyddusj/lyddusj.sh
25 10 * * * flock -n /var/run/update-list.lockfile -c /home/ubuntu/lyddusj/update-list.sh
```

