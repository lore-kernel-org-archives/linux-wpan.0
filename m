Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56400 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbcCWJU6 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 05:20:58 -0400
Subject: Re: at86rf212B 868Mhz
References: <CAPpUg6Mc_OcRtws_qqM9gcrWfDH+MpsLt8zm6Q9ODABHThOzKw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56F25FF6.4040500@osg.samsung.com>
Date: Wed, 23 Mar 2016 10:20:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAPpUg6Mc_OcRtws_qqM9gcrWfDH+MpsLt8zm6Q9ODABHThOzKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 22/03/16 19:48, Baptiste Clenet wrote:
> Hi,
>
> I've got two devices with a at86rf212B onboard: device A (ohter OS
> with at86rf212b driver) sending frame to device B  (running on Kernel
> 4.1 with the at86rf230 driver)
> Both has got a 868MHz antenna.
> Case 1: I set channel to 5 and page to 0 (914MHz according to
> datasheet) to both of them, it works fine, I can receive and send
> frames.
> Case 2: I set channel to 0 and page to 0 (868MHz according to
> dataheet) and I can't receive or send any frames.
>
> Alexander, have you already tried to run on 868MHz?
>

I'm not Alex but I can tell you that neither he or myself have 868 MHz 
capable hardware so we never have been able to test that on our side.

There could still be a bug in the driver or the iwpan page/channel 
setting somewhere. Printing out the values you get in the kernel (first 
the ones you get over netlink from iwpan and second the ones being set 
into the register) might give you a first clue if they actually compare 
to what the chip expects.

regards
Stefan Schmidt
