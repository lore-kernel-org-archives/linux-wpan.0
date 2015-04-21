Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from vpn-da.werderstrasse.de ([217.195.43.101]:46329 "EHLO
	sinabox.bfst.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbbDUHch convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Apr 2015 03:32:37 -0400
Message-ID: <5535FAE4.60302@ruecker.fi>
Date: Tue, 21 Apr 2015 07:23:16 +0000
From: =?UTF-8?B?IlRob21hcyBCLiBSw7xja2VyIg==?= <thomas@ruecker.fi>
MIME-Version: 1.0
Subject: Re: at86rf233 on BeagleBone Black
References: <551EDFCA.3070905@fid4.com> <20150403191320.GD773@omega> <20150414150656.GB2179@omega> <553024C3.2020207@fid4.com> <55307D66.7020606@gmail.com> <55310A85.5080601@fid4.com> <20150417221913.GA3338@omega> <55353FC0.5050909@fid4.com>
In-Reply-To: <55353FC0.5050909@fid4.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>, Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On 04/20/2015 06:04 PM, Michael C. Cambria wrote:
>
> On 04/17/2015 06:19 PM, Alexander Aring wrote:
>> On Fri, Apr 17, 2015 at 09:28:37AM -0400, Michael C. Cambria wrote:
>> ....
>>> With those changes the "arguments longer than property" message does go
>>> away.  I now get this probe error:
>>>
>>>
>>> [    9.815400] of_get_named_gpiod_flags: parsed 'reset-gpio'
>>> property of
>>> node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
>>> [    9.815437] of_get_named_gpiod_flags: parsed 'sleep-gpio'
>>> property of
>>> node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
>>> [   10.287193] at86rf230 spi1.0: Non-Atmel dev found (MAN_ID 00 00)
>>> [   10.971416] at86rf230: probe of spi1.0 failed with error -22
>>>
>> Meanwhile I got private repsonse that somebody have a working openlabs
>> module on a beaglebone, so it's _really_ possible! :-)
>
> Thanks for all the help.  My BBB now works with the openlabs radio.  I
> had P9_28 & P9_30 in the the wrong holes (blush).

Funny, that's pretty much the same type mistake that I made, before I
got things working. I was the person Alexander referred to earlier.

I have it working on a pretty much vanilla 4.0 (a rebuild of RCN's deb
package) on the BBB.


> I'll test e..g ping6 to another BBB and Pi ASAP.

Yeah, still have to test mine too. Started working on wiring another
openlabs module into a Minnowboard Max, but that needs writing a board
file...
I think I'll first just flash one of my CC2530 nodes for some simple tests.

Cheers

Thomas

