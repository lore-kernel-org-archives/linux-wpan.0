Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36573 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbEKR3y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 13:29:54 -0400
Received: by wizk4 with SMTP id k4so115062263wiz.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 May 2015 10:29:53 -0700 (PDT)
Date: Mon, 11 May 2015 19:29:47 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
Message-ID: <20150511172944.GA23185@omega>
References: <554E1C92.7040306@sssup.it>
 <20150509164227.GA694@omega>
 <5550DC2D.5060909@sssup.it>
 <20150511165127.GA1838@omega>
 <5550DFA3.5020806@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5550DFA3.5020806@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

On Mon, May 11, 2015 at 06:58:11PM +0200, Matteo Petracca wrote:
> This is basically what I have in my program:
> 
>   int socketfd = 0;
>   struct ifreq ifr;
>   static const char *wpandevs[] = {
>        "wpan0"
>   };
> 
> 
>  socket_config_wpan = wpandevs[0];
>  socketfd = socket(PF_IEEE802154, SOCK_RAW, 0);
> 
> strncpy(ifr.ifr_name, socket_config_wpan, IF_NAMESIZE);
>   ret = ioctl(socketfd, SIOCGIFADDR, &ifr);
>   if (ret < 0) {
>       fprintf(stderr,"ioctl: SIOCGIFADDR error\n");
>       return;
>    }
> 
>  In can say that in kernel 3.8.13 it works with no problems.
> 

I wrote a dirty hack [0]. Run it on my side and detected no issue.

The output is:

pan_id 0xabcd
short_addr 0x2

and that's my current pan_id and short_addr setting.

- Alex

[0] http://pastebin.com/EE5wGZ5Q
