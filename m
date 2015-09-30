Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.ltindia.com ([203.199.60.132]:45721 "EHLO
	mailout1.ltindia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbbI3LZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 07:25:43 -0400
From: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Subject: RE: Linux-Wpan-Next: Regarding usage of fakelb driver
Date: Wed, 30 Sep 2015 11:25:23 +0000
Message-ID: <51C7DE700DAED543997957503C74C845010745F2@POCITMSEXMB05.LntUniverse.com>
References: <51C7DE700DAED543997957503C74C84501073F5A@POCITMSEXMB05.LntUniverse.com>
 <20150929104158.GA1672@omega>
 <51C7DE700DAED543997957503C74C84501074016@POCITMSEXMB05.LntUniverse.com>,<20150929112815.GA25792@omega>
In-Reply-To: <20150929112815.GA25792@omega>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "kantanoop@yahoo.com" <kantanoop@yahoo.com>

Dear Alex,

Greetings!!

Thanks for detailed information!! I was able to bring up bluetooth_next/ fakelb/iwpan and wpan ping tool in linux machine with the information provided.

Further, I am trying to come up with virtual network (for eample pinging of IPV6 packets between two virtual nodes- packets going thorugh all the layes down to Phy layer and coming back to top layer) using fakelb on LInux machine itself.

I have seen that for earlier zigbee-linux ,we had detailed steps to demonstrate the functionality of the stack without real hardware, as given at below path :

http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2

Do we have something similar for the latest bluetooth-linux kernel which can help me to simulate WPAN network and verify messaging in LInux machine using fakelb / Or any information available if it has been tried by someone earlier?

Currently, I am analysing same, so just thought to check if some information on this already exist.

Note : So far, I am following the commands http://wpan.cakelab.org/#_how_to_8217_s and reached till this point. Now, further I want to simulate some network activity within Linux machine.

Regards,
Anoop



________________________________________
From: linux-wpan-owner@vger.kernel.org [linux-wpan-owner@vger.kernel.org] on behalf of Alexander Aring [alex.aring@gmail.com]
Sent: Tuesday, September 29, 2015 4:58 PM
To: Anoop Kant
Cc: Vikas Warad; Madhu Chinthakindi; kantanoop@yahoo.com; linux-wpan@vger.kernel.org
Subject: Re: Linux-Wpan-Next: Regarding usage of fakelb driver

On Tue, Sep 29, 2015 at 10:59:52AM +0000, Anoop Kant wrote:
> Dear Alex,
>
> Thanks for quick response!!
>
> I will build image using bluetooth-next git and try.
>
> I believe iwpan and wpan-ping (wpan tools) will already be present in the bluetooth-next-kernel built. Is that correct understanding ?

No, this is part of userspace you need to build it by yourself.

Newest release is 0.5 [0].

It's using autotools as buildsystem so a normal:

./confgure
make
(as root) make install

See [1].

should be enough, we have one dependency to libnl3. See [2], this should
be provided from your distribution which you install. (It's a common
library for networking utilities).

- Alex

[0] http://wpan.cakelab.org/releases/
[1] http://www.gnu.org/software/automake/manual/html_node/Basic-Installation.html#Basic-Installation
[2] http://www.infradead.org/~tgr/libnl (currently the site is down)
--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
L&T Technology Services Ltd

www.LntTechservices.com<http://www.lnttechservices.com/>

This Email may contain confidential or privileged information for the intended recipient (s). If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
