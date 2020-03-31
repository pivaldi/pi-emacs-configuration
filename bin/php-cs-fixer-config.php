#!/usr/bin/php
<?php

error_reporting(E_ALL | E_STRICT);

$finder = \PhpCsFixer\Finder::create();

return \PhpCsFixer\Config::create()
    ->setRules([
        '@Symfony' => true,
        'array_syntax' => ['syntax' => 'short'],
        'array_indentation' => true,
        'no_multiline_whitespace_before_semicolons' => false,
        'concat_space' => ['spacing' => 'one'],
    ])->setFinder($finder);
