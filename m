Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35913 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbcC3TVg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Mar 2016 15:21:36 -0400
Received: by mail-ig0-f182.google.com with SMTP id nk17so110311306igb.1
        for <linux-wpan@vger.kernel.org>; Wed, 30 Mar 2016 12:21:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56FB8E7F.70106@osg.samsung.com>
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
	<20160329083732.GA1114@omega>
	<CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
	<56FB8E7F.70106@osg.samsung.com>
Date: Thu, 31 Mar 2016 02:21:35 +0700
Message-ID: <CALqexQWw4QuPWxTDe8SdHxeOptq6TCf-O4Mq_UL-pDxqUz=h1A@mail.gmail.com>
Subject: Re: No device found for binding socket ieee802.15.4
From: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

> On 3/30/16, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Are you actually sure you have the socket code for ieee802154 enabled in
> your kernel build?
> CONFIG_IEEE802154_SOCKET
>
> If it is not build into the kernel, are you sure the module is loaded?
>
> regards
> Stefan Schmidt
>

Hi Stefan,

Fortunately I got 802.15.4 socket work by modifying wpan-ping code. By
the way, does the function generate_packet(unsigned char *buf, struct
config *conf, unsigned int seq_num) try to generate a packet which is
not 6LoWPAN? The code set 0x00 for the dispatch header. Now I need an
example of using 6LoWPAN socket API instead of creating packet
manually. Would anyone mind sharing the code if you have implement it?
