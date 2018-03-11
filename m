Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:39561 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932167AbeCKRak (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 11 Mar 2018 13:30:40 -0400
Date: Sun, 11 Mar 2018 18:30:39 +0100
From: anton@picapica.im
Subject: Re: "encryption failed" warnings in dmesg
Message-ID: <20180311173039.GA18490@picapica.im>
References: <20180307133525.GA30047@picapica.im>
 <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
 <20180310172932.GA17439@picapica.im>
 <CAOHTAphvdzndXp7EVMXXdvy_hbvSgR3O2jnEKKrSH074sMNQwg@mail.gmail.com>
 <CAOHTApgcEvkckSgCQ_cen-4Q2CTMwuQy8WReeZs-M4Zj6PfPiQ@mail.gmail.com>
 <20180311123745.GA11826@picapica.im>
 <CAB_54W7MUCeYj1Nvh0nuvf=MVNrM3HNZ=s3VvAz1imRd-RZm1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB_54W7MUCeYj1Nvh0nuvf=MVNrM3HNZ=s3VvAz1imRd-RZm1w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Aring <aring@mojatatu.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

On Sun, Mar 11, 2018 at 09:34:39AM -0400, Alexander Aring wrote:
> 
> > Seems working so far, at least instances are able to see each
> > other, pair up and even occasionally ping each other from CLI.
> 
> be prepared that the kernel will filter some stuff, you should change
> it that it will not do it. I think we would accept a patch to make
> that possible. The kernel is filtering -> you don't running a user
> space stack.

I tried to remove llsec_encrypt/llsec_decrypt from kernel, recompiled/rebooted,
pings started passing only after that, but still not all IPv6 addresses are pingable.
Seems that half of the packets are still filtered out somewhere.
What could be the other possible places in kernel where raw packets can be dropped?

Now I am trying to compare tcpdump dumps from both devices, with "node" type interfaces.

> 
> > Maybe more proper way is to set everything over netlingk,
> > but seems that extended addr cannot be changed on the fly anyway,
> > without bringing interface down
> >
> 
> The reason why we don't change address filtering at runtime is that we
> are in RX mode and we don't change RX parameters when we are in
> receive mode. If OpenThread, RIOT, etc. do that it's fine, but I see
> problems with that.
> 
> - Alex
