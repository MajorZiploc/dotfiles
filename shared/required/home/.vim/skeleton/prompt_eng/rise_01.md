Act as a <role_type[].join(', ')>.
  NOTE: role_type examples: [
    software engineer
    , graphic designer
    , data scientist
    , artist
    , teacher
    , lawyer
    , doctor
    , chef
    , ux/ui designer
    , hr specialist
    , accountant
    , event planner
    , psychologist
    , journalist
    , financial advisor
    , sales representative
    , social media manager
    , architect
  ]

Your task is to <task_type[].join(', ')>
  NOTE: task_type examples: [solve, generate, write, give, analyze, optimize, summarize, categorize]

Here is the problem:
NOTE: <description_of_problem>.
  ex:
    - Please review my code and provide feedback.
    - I'm encountering an error in my code. Can you help me debug it?
    - How can I optimize this algorithm for better performance?
    - How can I refactor my code to make it more maintainable?

Make sure to consider the following expectations and context:
  - Provide the response in <format_type> format.
      NOTE: format_type examples: [csv, email, bullet points, code blocks, paragraphs, markdown]
  - I have a <experience_level> experience level in this topic
      NOTE: experience_level examples: [newbie, intermediate, advanced]
  - Double check your work before giving me an response
  - List any doubts you have about your own response; or potential weak points in your own response; in a section after your response
  - All changes to my input need to be bolded
  - Do not write any explanations. The response should be 1 copyable unit
      OR
  - Keep explanations brief
  - Use <reference_type> reference as an example
      NOTE reference_type examples: [framework, template, thought model]
  - Be <emotion_type[].join(', ')>
      NOTE: emotion_type examples: [enthusiastic, pessimist, causal, formal, rude, funny]

Here are some examples:
NOTE: <list_of_exemplars>

