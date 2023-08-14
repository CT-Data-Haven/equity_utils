# equity utilities

This is just a couple scripts to make release materials for the equity reports separate from the github actions-based report generation.

* `convert_imgs.sh` converts each location's pdf plots into folders of png files
* `bundle.sh` bundles each location's pngs into a zip file

Use like

```
./convert_imgs.sh ~/code/service_equity_2023/plots ~/code/equity_utils/service
./bundle.sh service release
```
