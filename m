Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34842 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbbI3Ryu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 13:54:50 -0400
Received: by wicge5 with SMTP id ge5so208266033wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2015 10:54:49 -0700 (PDT)
Date: Wed, 30 Sep 2015 19:54:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Linux-Wpan-Next: Regarding usage of fakelb driver
Message-ID: <20150930175440.GB1246@omega>
References: <51C7DE700DAED543997957503C74C84501073F5A@POCITMSEXMB05.LntUniverse.com>
 <20150929104158.GA1672@omega>
 <51C7DE700DAED543997957503C74C84501074016@POCITMSEXMB05.LntUniverse.com>
 <20150929112815.GA25792@omega>
 <51C7DE700DAED543997957503C74C845010745F2@POCITMSEXMB05.LntUniverse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7DE700DAED543997957503C74C845010745F2@POCITMSEXMB05.LntUniverse.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "kantanoop@yahoo.com" <kantanoop@yahoo.com>

On Wed, Sep 30, 2015 at 11:25:23AM +0000, Anoop Kant wrote:
> Dear Alex,
> 
> Greetings!!
> 
> Thanks for detailed information!! I was able to bring up bluetooth_next/ fakelb/iwpan and wpan ping tool in linux machine with the information provided.
> 
> Further, I am trying to come up with virtual network (for eample pinging of IPV6 packets between two virtual nodes- packets going thorugh all the layes down to Phy layer and coming back to top layer) using fakelb on LInux machine itself.
> 
> I have seen that for earlier zigbee-linux ,we had detailed steps to demonstrate the functionality of the stack without real hardware, as given at below path :
> 
> http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
> 

Don't use this information. It's outdated and it's not easy to delete
sourceforge projects. :-)

> Do we have something similar for the latest bluetooth-linux kernel which can help me to simulate WPAN network and verify messaging in LInux machine using fakelb / Or any information available if it has been tried by someone earlier?
> 
> Currently, I am analysing same, so just thought to check if some information on this already exist.
> 
> Note : So far, I am following the commands http://wpan.cakelab.org/#_how_to_8217_s and reached till this point. Now, further I want to simulate some network activity within Linux machine.
> 

If your setup runs fine with bluetooth_next, wpan-tools and fakelb is
loaded.

Then iwpan dev should show two interfaces.

On each of them you need to set the pan_id e.g. "0xbeef", but not the
default one and create one lowpan interface on it. e.g.:

for pan_id:

iwpan dev wpan0 set pan_id 0xbeef
iwpan dev wpan1 set pan_id 0xbeef

for lowpan interface:

ip link add link wpan0 name lowpan0 type lowpan
ip link add link wpan1 name lowpan1 type lowpan

interface up:

ip link set wpan0 up
ip link set wpan1 up

ip link set lowpan0 up
ip link set lowpan1 up

getting default link-local address:

ip a

Then there should something like:

    inet6 fe80::b02f:76cc:1923:df59/64 scope link
           valid_lft forever preferred_lft forever

for the lowpan0 interface, the address differs because it's a random
generated one.

run ping6

ping6 -I lowpan1 fe80::b02f:76cc:1923:df59


I suppose here your interfaces are named "wpan0" and "wpan1".
The "fe80::b02f:76cc:1923:df59" is the address of lowpan0 and this is
why we use the "lowpan1" interface by calling: "ping6 -I lowpan1".


This should be enough to run some ping between the two virtual phy's.

- Alex
