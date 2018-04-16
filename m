Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:61115 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeDPNBj (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 16 Apr 2018 09:01:39 -0400
Subject: Re: [PATCH] ieee802154: assembly of 6LoWPAN fragments improvement
From: Stefan Schmidt <stefan@osg.samsung.com>
References: <20180221113540.GA54319@Rafael-Mac.intra.sownet.nl>
 <60c224d2-17e5-eaf8-2d1b-763ae4cd92db@osg.samsung.com>
 <20180222212407.GA82995@Rafael-Mac.intra.sownet.nl>
 <e387c90e-ad4d-994f-4043-b6b83eb7a2a8@osg.samsung.com>
Message-ID: <6a728b61-26f1-7a2a-779d-7205b3c7c3b1@osg.samsung.com>
Date: Mon, 16 Apr 2018 15:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <e387c90e-ad4d-994f-4043-b6b83eb7a2a8@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rafael Vuijk <r.vuijk@sownet.nl>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello Rafael.


On 02/26/2018 01:10 PM, Stefan Schmidt wrote:
> On 02/23/2018 12:10 AM, Rafael Vuijk wrote:
>> On Wed, Feb 21, 2018 at 05:31:07PM +0100, Stefan Schmidt wrote:
>>
>>> To me this looks like to distinguished things to fix and thus being fixed in two separate commits.
>> That makes sense. That'd be 1/2 v2 and 2/2 v2 or so?
>> I should split up my own commits more often too ;) (bad habit)
> Yes, splitting them up in 1/2 and 2/2 and adding the v2 version tag will help me and patchwork to keep track of it.
>

Just a quick note on this patch. I first waited for you to sent the split version. During this I sadly forgot
about this issue and patch all together during some travels.

Last week I finally remembered and wanted to setup a test case for this on my own. With the result
that I found a new patchset in 4.16 breaking 6LoWPAN fragmentation/reassembly for completely. Not
even initiating a ssh session works. I bisected the commit now and reported to the author. Hopefully
we can get this fixed soon.

In summary: your patch is nor forgotten and I still want to reproduce it and get your fix in (sorry for the delay)
You could help from your side by splitting the patch up and sending the second version. Once the above
mentioned other issue is fixed I will look into yours.

regards
Stefan Schmidt
