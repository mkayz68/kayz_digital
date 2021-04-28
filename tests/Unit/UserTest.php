<?php

namespace App\Tests\Unit;

use App\Entity\User;
use JetBrains\PhpStorm\Pure;
use PHPUnit\Framework\TestCase;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class UserTest extends KernelTestCase
{
    private $validator;

    protected function setUp(): void
    {

        $kernel = self::bootKernel();
        $kernel->boot();
        $this->validator = $kernel->getContainer()->get("validator");
    }

    public function testInstanceOf()
    {
        $user = new User;
        $this->assertInstanceOf(User::class, $user);
        $this->assertClassHasAttribute("prenom", User::class);
        $this->assertClassHasAttribute("nom", User::class);
    }
}
