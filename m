Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64349 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbAVWUT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jan 2015 17:20:19 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so24853715wiv.1
        for <linux-wpan@vger.kernel.org>; Thu, 22 Jan 2015 14:20:18 -0800 (PST)
Date: Thu, 22 Jan 2015 23:20:15 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Device or resource busy
Message-ID: <20150122222013.GB18612@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
 <20150120194407.GB18226@omega>
 <CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
 <CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
 <54bf9983.07f4440a.7103.0a2e@mx.google.com>
 <20150121154634.GA664@omega>
 <CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
 <20150122205920.GA18612@omega>
 <CAFUtXGwkG7p-LLjRdV5fKrCLQMMVJzMDqBtG4Dt148xAKAm-XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUtXGwkG7p-LLjRdV5fKrCLQMMVJzMDqBtG4Dt148xAKAm-XQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: Rohit Kulkarni <rmkulkar@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Thu, Jan 22, 2015 at 10:58:32PM +0100, Maciej Wasilak wrote:
...
> socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
> access("/proc/net/if_inet6", R_OK)      = 0
> socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 5
> access("/proc/net/ax25", R_OK)          = -1 ENOENT (No such file or directory)
> access("/proc/net/nr", R_OK)            = -1 ENOENT (No such file or directory)
> access("/proc/net/rose", R_OK)          = -1 ENOENT (No such file or directory)
> access("/proc/net/ipx", R_OK)           = -1 ENOENT (No such file or directory)
> access("/proc/net/appletalk", R_OK)     = -1 ENOENT (No such file or directory)
> access("/proc/sys/net/econet", R_OK)    = -1 ENOENT (No such file or directory)
> access("/proc/sys/net/ash", R_OK)       = -1 ENOENT (No such file or directory)
> access("/proc/net/x25", R_OK)           = -1 ENOENT (No such file or directory)
> ioctl(4, SIOCGIFFLAGS, {ifr_name="wpan0",
> ifr_flags=IFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_NOARP}) = 0
> ioctl(4, SIOCSIFFLAGS, {ifr_name="wpan0",
> ifr_flags=IFF_BROADCAST|IFF_RUNNING|IFF_NOARP}) = 0
> exit_group(0)                           = ?
> 

I see no issues here. The values also readback and there is no "IFF_UP"
in the last ioctl of file descriptor 4.

Do you are sure that there is no daemon running or something else which
automatically ifup the interface again if you want to set it down? Maybe
just mv the /etc/$NETWORKING_STUFF into a separate directory and try again.

- Alex
