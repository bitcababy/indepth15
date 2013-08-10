module Topics
MAJOR_TOPIC_MAP = {
    'Geometry' => [
      'Transformations', 'Similarity', 'Congruence', 'Logic/Proof',
      'Measurement', 'Non-Euclidean', 'Circles', 'Polygons', 'Parallel Lines'
    ],
    'Algebra' => [
      'Functions',
      'Quadratics',
      'Exponents/Logs',
      'Systems of Equations',
      'Number Theory',
      'Probability/Combinatorics',
      'Data Distributions',
      'Correlation/Regression',
    ],
    'Precalculus' => [
      'Functions',
      'Trigonometry',
      'Probability/Combinatorics',
      'Complex Numbers',
      'Polynomials',
      'Iteration',
      'Rational Functions',
      'Logic/Proof',
      'Number Theory',
    ],
    'Calculus' => [
      'Limits',
      'Sequences/Series',
      'Derivatives',
      'Integrals',
    ],
    'Statistics' => [
      'Data Distributions',
      'Data Collection',
      'Sampling Distributions',
      'Inference',
      'Correlation/Regression',
    ],
    'Discrete Math' => [
      'Inference',
      'Data Collection',
      'Queueing Theory',
      'Manhattan Metric',
      'Game Theory',
      'Graph Theory',
      'Emergence',
      'Risk Analysis',
    ],
  }
  BRANCH_MAP = {
    321 => 'Geometry',
    322 => 'Geometry',
    326 => 'Algebra',
    331 => 'Algebra',
    332 => 'Algebra',
    333 => 'Algebra',
    341 => 'Precalculus',
    342 => ['Precalculus', 'Statistics', 'Algebra'],
    343 => 'Discrete Math',
    352 => 'Precalculus',
    361 => 'Calculus',
    371 => 'Calculus',
    391 => 'Statistics',
  }

end
