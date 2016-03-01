Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52444 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbcCAJP3 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 1 Mar 2016 04:15:29 -0500
Subject: Re: 802.15.4G support?
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56D55DAD.4040103@osg.samsung.com>
Date: Tue, 1 Mar 2016 10:15:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

Hello.

On 25/02/16 19:22, Remi Philippe wrote:
> Hello,
>
> We’re currently developing a driver for RF215 (dual radio) using

You mean the at86rf215 here, right?
http://www.atmel.com/images/atmel-42415-wireless-at86rf215_datasheet.pdf

> 6lowpan and are nearly done with it.

Great. I hope you plan to send it for mainline inclusion. Is is a 
complete new driver or did you work on extending the at86rf2xx driver to 
support this chip?

> We’ve figured out the current MAC
> and PHY are built for 15.4 and not 15.4g which is a blocking point the
> sub-ghz module.

That is correct. So far nobody did any work on supporting 15.4g  and to 
answer the question from below I also do not know anyone actually 
working on it. So you could jump to the coding. :)
>
>
> It doesn’t look like there is a need for a huge amount of work to get
> a basic version of it working (key ones we’ve seen are different MTU
> and also some changes in the header like PHR).

Alex already gave you some hints about handling the different MTU size 
for SUN phys. The sub GHz frequency bands and channel setting should 
already be covered in the kernel and wpan-tools. We might miss some 
corner cases as Alex and myself do not have sub GHz hardware but they 
should not be that hard to handle.

Can you elaborate on the problem with the PHR header?

For the chip with two phy I expect you will just expose two different 
phy's and we need no special handling for it. Are there any limitation 
on the chip side like a shared frame buffer or regs which might extra 
logic in the core?

Are there any other MAC related changes in 15.4g? I briefly looked at it 
but the abstract of changes has been very vague ("In addition to the
new PHYs, the amendment also defines those MAC modifications needed to 
support their implementation.") and reading the whole 252 pages was to 
much for this morning. :)

>
> Before jumping in coding, is anyone on the list already working on
> this? Or has any starting points.

Its an area nobody is working on as far as we now. Be our guest here. We 
are happy to review patches for it.
Btw, do you happen to know if 15.4g was merged into 2015 edition of the 
main 15.4 spec or is it still a separate spec?

regards
Stefan Schmidt
