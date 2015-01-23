Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:41568 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbAWH7L (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Jan 2015 02:59:11 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so6042784wes.10
        for <linux-wpan@vger.kernel.org>; Thu, 22 Jan 2015 23:59:09 -0800 (PST)
Date: Fri, 23 Jan 2015 08:59:03 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Device or resource busy
Message-ID: <20150123075902.GA11163@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
 <20150120194407.GB18226@omega>
 <CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
 <CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
 <54bf9983.07f4440a.7103.0a2e@mx.google.com>
 <20150121154634.GA664@omega>
 <CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
 <20150122205920.GA18612@omega>
 <CAFUtXGwkG7p-LLjRdV5fKrCLQMMVJzMDqBtG4Dt148xAKAm-XQ@mail.gmail.com>
 <20150122222013.GB18612@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150122222013.GB18612@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: Rohit Kulkarni <rmkulkar@gmail.com>, linux-wpan@vger.kernel.org

On Thu, Jan 22, 2015 at 11:20:13PM +0100, Alexander Aring wrote:
> Hi,
> 
> On Thu, Jan 22, 2015 at 10:58:32PM +0100, Maciej Wasilak wrote:
> ...
> > socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
> > access("/proc/net/if_inet6", R_OK)      = 0
> > socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 5
> > access("/proc/net/ax25", R_OK)          = -1 ENOENT (No such file or directory)
> > access("/proc/net/nr", R_OK)            = -1 ENOENT (No such file or directory)
> > access("/proc/net/rose", R_OK)          = -1 ENOENT (No such file or directory)
> > access("/proc/net/ipx", R_OK)           = -1 ENOENT (No such file or directory)
> > access("/proc/net/appletalk", R_OK)     = -1 ENOENT (No such file or directory)
> > access("/proc/sys/net/econet", R_OK)    = -1 ENOENT (No such file or directory)
> > access("/proc/sys/net/ash", R_OK)       = -1 ENOENT (No such file or directory)
> > access("/proc/net/x25", R_OK)           = -1 ENOENT (No such file or directory)
> > ioctl(4, SIOCGIFFLAGS, {ifr_name="wpan0",
> > ifr_flags=IFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_NOARP}) = 0
> > ioctl(4, SIOCSIFFLAGS, {ifr_name="wpan0",
> > ifr_flags=IFF_BROADCAST|IFF_RUNNING|IFF_NOARP}) = 0
> > exit_group(0)                           = ?
> > 
> 
> I see no issues here. The values also readback and there is no "IFF_UP"
> in the last ioctl of file descriptor 4.
> 
> Do you are sure that there is no daemon running or something else which
> automatically ifup the interface again if you want to set it down? Maybe
> just mv the /etc/$NETWORKING_STUFF into a separate directory and try again.
> 

Maybe something like this?

http://unix.stackexchange.com/questions/50602/cant-ifdown-eth0-main-interface

- Alex
