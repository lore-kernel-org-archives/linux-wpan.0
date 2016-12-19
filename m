Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35777 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbcLSJwA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Dec 2016 04:52:00 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so59600564pga.2
        for <linux-wpan@vger.kernel.org>; Mon, 19 Dec 2016 01:52:00 -0800 (PST)
Message-ID: <1482141113.21188.195.camel@newmarch.name>
Subject: Re: Requesting for info about 15.4 network enabling...
From: Jan Newmarch <jan@newmarch.name>
Date: Mon, 19 Dec 2016 20:51:53 +1100
In-Reply-To: <CAAK7Ti89EqhctExJG8+cbeeCM9Ez2f0eE6tdAV_whC=yN_pY3g@mail.gmail.com>
References: <CAAK7Ti89EqhctExJG8+cbeeCM9Ez2f0eE6tdAV_whC=yN_pY3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>, linux-wpan@vger.kernel.org

I have an article in the Linux Journal for December 2016 addressing
this issue. It should become publicly available in January, but is
currently available as a paid resource from 
http://www.linuxjournal.com/content/linux-journal-december-2016

Basically, you have to give the 6lowpan device a unique local or global
address. The Ipv6 address automatically assigned is a link local
address and isn't routable. You also have to set up your connection to
the external network to be a gateway. If that is a Linux box, you need
to set IPv6 forwarding in /etc/sysctl.conf. Using radvd to configure
your RPi network is also useful. Then with a bit of huffing and puffing
it should work

Cheers

Jan
-- 
Dr Jan Newmarch,
Head of Higher Education (ICT) @ Box Hill,
Adjunct Professor @ University of Canberra

P 61 3 9286 9971
M +61 4 0117 0509
F 61 3 9286 9100
W www.boxhill.edu.au
W jan.newmarch.name
E j.newmarch@boxhill.edu.au
E jan@newmarch.name




On Mon, 2016-12-19 at 14:35 +0530, JANARDHANACHARI KELLA wrote:
> Hi to all,
> 
> I am trying to enable 6lowpan network in raspberry pi..
> I have built kernel with enabling 6lowpan network and drivers. I wish
> to route the devices from out side of the network... What I have to
> do?
> Please any one can help me,  how to process...
> 
> 
