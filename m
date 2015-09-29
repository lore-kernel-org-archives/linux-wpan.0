Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36823 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934680AbbI2KmK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Sep 2015 06:42:10 -0400
Received: by wicgb1 with SMTP id gb1so142775606wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 29 Sep 2015 03:42:09 -0700 (PDT)
Date: Tue, 29 Sep 2015 12:42:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Linux-Wpan-Next: Regarding usage of fakelb driver
Message-ID: <20150929104158.GA1672@omega>
References: <51C7DE700DAED543997957503C74C84501073F5A@POCITMSEXMB05.LntUniverse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7DE700DAED543997957503C74C84501073F5A@POCITMSEXMB05.LntUniverse.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Cc: linux-wpan@vger.kernel.org

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
