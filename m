Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.ltindia.com ([203.199.60.171]:31361 "EHLO
	mailout2.ltindia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934494AbbI2LYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Sep 2015 07:24:30 -0400
From: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Subject: RE: Linux-Wpan-Next: Regarding usage of fakelb driver
Date: Tue, 29 Sep 2015 10:59:52 +0000
Message-ID: <51C7DE700DAED543997957503C74C84501074016@POCITMSEXMB05.LntUniverse.com>
References: <51C7DE700DAED543997957503C74C84501073F5A@POCITMSEXMB05.LntUniverse.com>,<20150929104158.GA1672@omega>
In-Reply-To: <20150929104158.GA1672@omega>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Vikas Warad <Vikas.Warad@LNTTECHSERVICES.COM>, Madhu Chinthakindi <Madhu.Chinthakindi@LNTTECHSERVICES.COM>Vikas Warad <Vikas.Warad@LNTTECHSERVICES.COM>, "kantanoop@yahoo.com" <kantanoop@yahoo.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Dear Alex,

Thanks for quick response!!

I will build image using bluetooth-next git and try.

I believe iwpan and wpan-ping (wpan tools) will already be present in the bluetooth-next-kernel built. Is that correct understanding ?

Regards,
Anoop
________________________________________
From: Alexander Aring [alex.aring@gmail.com]
Sent: Tuesday, September 29, 2015 4:12 PM
To: Anoop Kant
Cc: linux-wpan@vger.kernel.org
Subject: Re: Linux-Wpan-Next: Regarding usage of fakelb driver

Hi,

On Tue, Sep 29, 2015 at 09:01:16AM +0000, Anoop Kant wrote:
> Dear Alex,
>
> Greetings!!
>
> I am trying to use a simulated network environment using fakelb. I have built image using latest Linux-Wpan-Next files. The image is built and running in x86_64 machine.
>
> Now, could you guide me where can I get help on how to use this fake drivers.
>
> I tried to follow the instructions given at https://code.google.com/p/linux-wsn/wiki/Mainline
> But, I am not able to register loopback driver as I am getting issue. I am getting module instering error while trying below command.
>
> # insmod fakelb.ko
>
> Could you please guide me where can I refer for steps to follow for this ?
>

The new website is [0].

Please don't use linux-wpan-next. Our current working repository is
bluetooth-next [1]. If you like to send patches your patches need to
base on bluetooth-next. See [2].

For testing fakelb I would advice you to create some qemu/virtualbox
machine with a recent bluetooth-next kernel.

Then if fakelb driver is built as module you need to call "modprobe
fakelb", if everything is okay then you will see two new wpan phy's by
calling:

iwpan phy

by default a wpan phy will create one node interface, so you will have
two wpan interfaces "wpan0/wpan1" by default. You can check this by calling:

iwpan dev

To setup the interfaces/phy and 6lopwan (if you want that), you can call
"iwpan" for all possible settings and follow the instructions at [3].

- Alex

[0] http://wpan.cakelab.org/
[1] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git
[2] http://wpan.cakelab.org/#_developing
[3] http://wpan.cakelab.org/#_how_to_8217_s
L&T Technology Services Ltd

www.LntTechservices.com<http://www.lnttechservices.com/>

This Email may contain confidential or privileged information for the intended recipient (s). If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
