Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59224 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932564AbcC3I34 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 04:29:56 -0400
Subject: Re: No device found for binding socket ieee802.15.4
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
 <20160329083732.GA1114@omega>
 <CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FB8E7F.70106@osg.samsung.com>
Date: Wed, 30 Mar 2016 10:29:51 +0200
MIME-Version: 1.0
In-Reply-To: <CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Adika Bintang Sulaeman <adikabintang78@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hello.

On 30/03/16 03:43, Adika Bintang Sulaeman wrote:
> Hi Alexander Aring,
>
> I have watched your presentation on [1] and I saw that you had the
> "Link encap: UNSPEC" as well. Thank you for your explanation. I hope I
> can get some directions or hints about the problem I face on running
> "wpan-ping --daemon" and the socket for 802.15.4.

Are you actually sure you have the socket code for ieee802154 enabled in 
your kernel build?
CONFIG_IEEE802154_SOCKET

If it is not build into the kernel, are you sure the module is loaded?

regards
Stefan Schmidt
