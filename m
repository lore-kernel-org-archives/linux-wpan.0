Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bn1on0062.outbound.protection.outlook.com ([157.56.110.62]:30237
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754158AbbHNOtg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 14 Aug 2015 10:49:36 -0400
Message-ID: <55CDFECD.80907@analog.com>
Date: Fri, 14 Aug 2015 16:44:29 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
Subject: Re: ADF7242 driver ready for mainline inclusion?
References: <55CC5CF3.5030701@sostec.de> <78F369B105E123488216BDB7B6C397DAA4DA4FD8@NWD2MBX7.ad.analog.com> <55CD9513.8020508@datenfreihafen.org>
In-Reply-To: <55CD9513.8020508@datenfreihafen.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On 08/14/2015 09:13 AM, Stefan Schmidt wrote:
> Hello.
>
> On 13/08/15 20:50, Hennerich, Michael wrote:
>> Hi All,
>>
>> I did tis driver a long time ago, when the Linux 802.15.4 support in general was at its beginning and pretty broken as well.
>>  From time to time I update this driver - and actually it's pretty mature - and should apply to mainline without problems.
>>
>> There is currently only one minor thing that I wanted to investigate (some ifdef in the ISR) before submitting the driver mainline.
> This is great to hear! Looking forward to it. :)
>> Are you using the ADF7242 in a design already?
> No. The reason I wrote this is that I have an interest in the linux-wpan
> subsystem in general and thought the driver would be a good candidate
> for mainline.
>
> I actually searched for some simple ADF7242which I could hook up to SPI
> + IRQ and maybe some more control lines. So far I only found the
> official evaluation board which is to expensive for some hobbyist testing.

Well there is the EVAL-ADF7242-PMOD [1] which uses a PMOD [2] interface
basically a cheap 100mil spaced header, with SPI, IRQ and supply.

If you are really interested testing the driver I can provide you one FOC.

>> Do you have feedback already?
> The driver interface for ieee802154 has advanced since the it got merged
> initially. Some of the new things you might want to look into and add
> support are:
>
> o Async transmit (xmit_async)
> o LBT support (set_lbt)
> o Set CC mode and ed level (set_cc_mode, set_cca_ed_level)
> o Support for monitor mode (set_promiscuous_mode)
>
> These I found missing when having a brief look over the driver.

Thanks for the summary!

>
> regards
> Stefan Schmidt
>

[1] 
http://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/EVAL-ADF7242-PMOD.html
[2] 
https://www.digilentinc.com/Pmods/Digilent-Pmod_%20Interface_Specification.pdf

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif

