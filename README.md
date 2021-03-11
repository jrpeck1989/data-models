[![License][license-image]][license]

![snowplow-logo](media/snowplow_logo.png)

Snowplow is a scalable open-source platform for rich, high quality, low-latency data collection. It is designed to collect high quality, complete behavioural data for enterprise business.

# Snowplow Pipeline Overview

![snowplow-pipeline](media/snowplow_pipeline.png)

The [Snowplow trackers][tracker-docs] enable highly customisable collection of raw, unopinionated event data. The pipeline validates these events against a JSONSchema - to guarantee a high quality dataset - and adds information via both standard and custom enrichments.

This data is then made available in-stream for real-time processing, and can also be loaded to blob storage and data warehouse for analysis.

The Snowplow atomic data acts as an immutable log of all the actions that occurred across your digital products. The data model takes that data and transforms it into a set of derived tables optimized for analysis. [Visit our documentation site][docs-what-is-dm] for further explanation on the data modeling process.

# Try Snowplow

This repo contains data models which are relevant to users who already have a full Snowplow pipeline running (which can be done Open Source or via our [Snowplow Insights](https://snowplowanalytics.com/snowplow-insights/) service).

If you don't have a pipeline yet, you might be interested in finding out what Snowplow can do by setting up [Try Snowplow](https://try.snowplowanalytics.com/?utm_source=github&utm_medium=post&utm_campaign=try-snowplow).

# Repo Contents

- [Web (v1)](web/v1)
  - [Redshift](web/v1/redshift) [![actively-maintained]][tracker-classificiation]
  - [BigQuery](web/v1/bigquery) [![actively-maintained]][tracker-classificiation]
  - [Snowflake](web/v1/snowflake) [![actively-maintained]][tracker-classificiation]
- Mobile (coming soon)
  - Redshift (coming soon)
  - BigQuery (coming soon)
  - Snowflake (coming soon)

Documentation for the data models can be found on [our documentation site][docs-data-models].

# Prerequisites

These models are written in a format that is runnable via [SQL-runner][sql-runner] - available for download as a zip file from [Github Releases][sql-runner-github]. The bigquery model requires >= v0.9.2, and the Snowflake model requires >= v0.9.3 of sql-runner.

Those who don't wish to use sql-runner to run models can use the -t and -o flags of the run_config.sh script to output the pure sql for a model according to how it has been configured for sql-runner.

They each also require a dataset of Snowplow events, generated by one of [the tracking SDKs][tracker-docs], passed through the validation and enrichment steps of the pipeline, and loaded to a database.

For the testing framework, Python3 is required. Install requirements with:

```bash
cd .tests
pip3 install -r requirements.txt
```

# Quickstart

To run a model and tests end to end, run the `.scripts/e2e.sh` bash script.

![end-to-end](media/e2e.gif)

For a quickstart guide to each individual model, and specific details on each module, see the README in the model's database-specific folder (eg. `web/v1/redshift`).

For detail on the structure of a model, see the README in the model's main folder (eg. `web/v1`).

For detail on using the helper scripts, see the README in `.scripts/`

# Running models in production

## Using SQL-runner

### Snowplow insights

Snowplow Insights customers can configure jobs for SQL-runner in production via configuration files. [See our docs site for details on doing so](https://docs.snowplowanalytics.com/docs/modeling-your-data/configuring-and-running-data-models-via-snowplow-insights/). The `configs/datamodeling.json` file in each model is an example configuration for the standard model. The `configs/example_with_custom.json` file is an example configuration with a customisation.

### Open Source

For open-source users, the JSON files in `configs` folders can't be directly used, but serve as a representation of the dependencies for what to run. Open Source users using SQL-runner should instrument their jobs to run playbooks individually according to the dependencies specified.

For local use, the `.scripts/run_config.sh` script can be used to run a config - note that it does not resolve dependencies but runs the playbooks in order of appearance.

## Using other tools

For those who wish to use other tools, one may configure playbooks and config JSON files for the desired model, then use the `.scripts/run_configs.sh` script's `-p` and `-o` flags to fill templates and output pure SQL to file:

```bash
bash .scripts/run_config.sh -b ~/pathTo/sql-runner -c web/v1/bigquery/sql-runner/configs/example_with_custom.json -p -o tmp/sql;
```

This SQL can then be used directly or amended to suit the relevant tool.

# Copyright and license

The Snowplow Data Models project is Copyright 2020-2021 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[license]: http://www.apache.org/licenses/LICENSE-2.0
[license-image]: http://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[tracker-classificiation]: https://docs.snowplowanalytics.com/docs/collecting-data/collecting-from-own-applications/tracker-maintenance-classification/
[actively-maintained]: https://img.shields.io/static/v1?style=flat&label=Snowplow&message=Actively%20Maintained&color=6638b8&labelColor=9ba0aa&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAeFBMVEVMaXGXANeYANeXANZbAJmXANeUANSQAM+XANeMAMpaAJhZAJeZANiXANaXANaOAM2WANVnAKWXANZ9ALtmAKVaAJmXANZaAJlXAJZdAJxaAJlZAJdbAJlbAJmQAM+UANKZANhhAJ+EAL+BAL9oAKZnAKVjAKF1ALNBd8J1AAAAKHRSTlMAa1hWXyteBTQJIEwRgUh2JjJon21wcBgNfmc+JlOBQjwezWF2l5dXzkW3/wAAAHpJREFUeNokhQOCA1EAxTL85hi7dXv/E5YPCYBq5DeN4pcqV1XbtW/xTVMIMAZE0cBHEaZhBmIQwCFofeprPUHqjmD/+7peztd62dWQRkvrQayXkn01f/gWp2CrxfjY7rcZ5V7DEMDQgmEozFpZqLUYDsNwOqbnMLwPAJEwCopZxKttAAAAAElFTkSuQmCC

[tracker-docs]: https://docs.snowplowanalytics.com/docs/collecting-data/collecting-from-own-applications/
[docs-what-is-dm]: https://docs.snowplowanalytics.com/docs/modeling-your-data/what-is-data-modeling/
[docs-data-models]: https://docs.snowplowanalytics.com/docs/modeling-your-data/

[sql-runner]: https://github.com/snowplow/sql-runner
[sql-runner-github]: https://github.com/snowplow/sql-runner/releases/
