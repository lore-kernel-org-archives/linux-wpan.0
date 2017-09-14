Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44961
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751255AbdINOJo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Sep 2017 10:09:44 -0400
Subject: Re: IEEE80154 sockets problem with kernel 4.1.15
References: <20170727123925.Horde.wOM_gZTTS3ppRvU-NkGUfQ1@webmail.cnit.it>
 <CAOHTApg2Xt1vRbqZpMamQCuHxby5p7E4TA2ctx0sjR387PfHgQ@mail.gmail.com>
 <20170914130320.Horde.V6cTm9S8-dERpl3Ztcq_oA2@webmail.cnit.it>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <1fccadc0-0661-8405-2bf6-01bb7047af7d@osg.samsung.com>
Date: Thu, 14 Sep 2017 16:09:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170914130320.Horde.V6cTm9S8-dERpl3Ztcq_oA2@webmail.cnit.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: ldimauro <ldimauro@cnit.it>, Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 09/14/2017 03:03 PM, ldimauro wrote:
> Dear all,
> i've tried to change "iface.c" file, 

That does mean that you took the fix Alex mentioned and backported it to 
your kernel? Did you do a cherry-pick or did you try it manually.

but when i try to do a network
> shell command (like "ifconfig"), system stall and doesn't accept any input.
> The main problem is that I'm forced to use this kernel with this OS.

4.1.15 was released in December 2015. That is almost two years behind 
what we are working on. It may sound harsh but we simply can not support 
every old kernel out there. Many fixes have been done since then and 
integrated into newer kernels. Taking away several hours of our own time 
to setup a test with your old kernel to support you is nothing that can 
be asked from such a small community (2+ active developers).

> Do you have any solutions to offer?

Alex offered you the solution already by pointing out the commit that 
fixes the issue in newer kernel. Getting it (and maybe more patches) 
properly backported is something that would need to be done on your end.

I just tried the test code you posted on a 4.12.9 kernel and problem 
does not show up.

regards
Stefan Schmidt
