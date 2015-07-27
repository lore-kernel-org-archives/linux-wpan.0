Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38536 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbbG0KVM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 06:21:12 -0400
Received: by wibxm9 with SMTP id xm9so109518591wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 03:21:11 -0700 (PDT)
Date: Mon, 27 Jul 2015 12:21:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150727102121.GC18090@omega>
References: <20150724130747.GA6051@omega>
 <CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
 <55B250E2.7020906@osg.samsung.com>
 <CAPpUg6MdwB_tN8nfDsWPas2rYFhkaue8N9rpSxgt4jPn_W8VYw@mail.gmail.com>
 <CAPpUg6NmUmNFvWMpvOuuB1LanD5r5t1NyugMsFfz=sfYUUgyiA@mail.gmail.com>
 <20150727083202.GA3071@omega>
 <CAPpUg6PO+xLkZLBPp7WCgBoBx78uocJ_WUBez97fbqfiMNMe2w@mail.gmail.com>
 <CAPpUg6Pzyptjv-5ygaz8TqaZMiASKr7PR2j6mxt1SOuKs9bhsw@mail.gmail.com>
 <20150727093018.GB18090@omega>
 <CAPpUg6PBF9mSOkcNRdN-nqKPan+wmD5iQaMBqV0zpVDY+ccE3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6PBF9mSOkcNRdN-nqKPan+wmD5iQaMBqV0zpVDY+ccE3w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

On Mon, Jul 27, 2015 at 12:08:18PM +0200, Baptiste Clenet wrote:
...
> 
> Receiving side:
> [  176.921637] CID flag is set, increase header with one
> [  176.931640] NH flag is set, next header carried inline: 02
> [  176.942502] SAC bit is set. Handle context based source address.
> [  176.954397]
> [  176.957352] ieee802154 phy0 wpan0: SAM value 0x3 not supported
> 

Yes this is not what it was transmitted before from the other node.
That's why I would ask for some sniffing device, somewhere in the lower
layers mac or phy it will fill your frame with garbage.

I can't tell you now if it's the transmitted node or the receiving node.
You need to debug it there.

To ensure the transmitted node don't send garbage I would like to check
it with some sniffer device. If you see garbage on the sniffer device
then it's something wrong with the transmitting.

- Alex
