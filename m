Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.snt.utwente.nl ([130.89.149.33]:43884 "EHLO
	mx1.snt.utwente.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcBVMmX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Feb 2016 07:42:23 -0500
From: Koen Zandberg <koen@bergzand.net>
Subject: Re: extending driver mrf24j40
References: <1A88240A-AAAD-4243-A31C-61CBC7E8949F@mlng.net>
 <56C9ADBB.1040608@pengutronix.de> <56C9B125.2030409@bergzand.net>
 <3C6ECFF9-7B13-42A3-8A4B-1258CA1926C5@mlng.net>
Message-ID: <56CB021B.5040305@bergzand.net>
Date: Mon, 22 Feb 2016 13:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <3C6ECFF9-7B13-42A3-8A4B-1258CA1926C5@mlng.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: smlng <s@mlng.net>
Cc: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org, Alan Ott <alan@signal11.us>

On 22-2-2016 10:09, smlng wrote:
> Hi all,
>
> thanks for the replies and input. I'm happy to contribute on the enhancing the mrf24j40 driver and I've some time to spare on that.
>
> @Koen: briefly said my plan is to _port_ some of the functionality (i.e., reset) from the at86rf230 driver - I know it's a different device but the driver seems to be well written and implements/uses reset, sleep and so on. I think it is a good starting point, or not? Currently I've 1 (maybe 2) mrf24j40ma transceiver(s) at my disposal, and use them with a Raspberry Pi via SPI for testing.
>
> I'll report back, as soon as I got some of the planned _enhancements_ running, maybe you (@Koen) can review and test them as well?
>
> Best
>   Sebastian
Hello,

If you've got any patches that need testing send them this way, I can 
test them. My test setup consists of three raspberry pi's, all of them 
with mrf24j40ma radios. Unfortunately I don't have a logic analyser so I 
can't verify whether reset or wake signals are correctly applied.

Regards
Koen
