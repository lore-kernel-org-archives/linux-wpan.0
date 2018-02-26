Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:56380 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbeBZLx6 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 26 Feb 2018 06:53:58 -0500
Subject: Re: [PATCH] website: Add troubleshooting section in how-tos
References: <20180218230316.GA8719@picapica.im>
 <1dd13aca-fc2d-82fb-821e-3b1994f26930@osg.samsung.com>
 <CAB_54W7jQzAO_fYRKV=qJHxxDfnpk=ddNrF20yvCRbdp70KwEg@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <fd14390a-38b7-a120-3a3f-6e9a6fe44e11@osg.samsung.com>
Date: Mon, 26 Feb 2018 12:53:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAB_54W7jQzAO_fYRKV=qJHxxDfnpk=ddNrF20yvCRbdp70KwEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: anton@picapica.im, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello.


On 02/25/2018 11:02 PM, Alexander Aring wrote:
> Hi,
>
>> Thanks for the patch I applied and pushed it to the repo now.
>> While doing this I toke the freedom to replace your email with name and email in the from line to ahve your name show up correctly in git.
>>
>> Alex, could you re-generate the website to get this included?
> I regenerate and updated the website... 

Thanks

I also spent some time at the weekend to get the hosting on githuib pages going.


http://linux-wpan.org/ (no https or IPv6 so far as github is still working on getting this rolled out for github pages with own domain
names. At least https seems to be in progress more recently)
https://linux-wpan.github.io/ (for https and IPv6 access)

This has a copy of the latest generated html page we serve on our current side as well.

Todo items before we could switch over:
1) Find a way to run the generator on commits (or simply to the generating by hand prior to check in)
2) http redirect from cakelab page to new domain (Alex, I can help you with the place holder html page to put there but you would need to
upload it)

Mid term:
o Monitor GitHub progress on using https with custom domain
o Monitor GitHub progress on using IPv6 with custom domain
o Maybe switch to a different theme or at least re-structure the content of the page

regards
Stefan Schmidt
