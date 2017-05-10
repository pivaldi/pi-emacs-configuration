#!/usr/bin/php
<?php

error_reporting(E_ALL | E_STRICT);

$finder = \PhpCsFixer\Finder::create()->in(__DIR__);

return \PhpCsFixer\Config::create()
    ->setRules([
        '@Symfony' => true,
        'array_syntax' => ['syntax' => 'short'],
        'no_multiline_whitespace_before_semicolons' => true,
        'concat_space' => true,
    ])->setFinder($finder);
