/*
   Copyright 2021 Snowplow Analytics Ltd. All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

-- 2. Commit table procedure handles committing to prod, including table creation, and creation of new columns if 'automigrate' is set to TRUE

CALL {{.output_schema}}.commit_table('{{.scratch_schema}}',              -- source schema
                                     'session_goals_staged{{.entropy}}', -- source table
                                     '{{.output_schema}}',               -- target schema
                                     'session_goals{{.entropy}}',        -- target table
                                     'session_id',                       -- join key
                                     'start_tstamp',                     -- partition key
                                      TRUE);                             -- automigrate

-- If we like, we can manually create and update our production table instead.
