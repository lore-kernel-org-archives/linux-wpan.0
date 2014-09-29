Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48308 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaI2NMI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 09:12:08 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so1882848wib.0
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 06:12:07 -0700 (PDT)
Date: Mon, 29 Sep 2014 15:12:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929131200.GA14608@omega>
References: <54258332.2010004@xsilon.com>
 <20140926153521.GA7643@omega>
 <542593AC.4060901@xsilon.com>
 <20140927014243.GA26666@omega>
 <54293279.5090103@xsilon.com>
 <54293B6C.7040800@gmail.com>
 <54293DD4.1090907@xsilon.com>
 <5429441C.5000302@gmail.com>
 <5429466F.4080506@gmail.com>
 <54295556.3030800@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54295556.3030800@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Mon, Sep 29, 2014 at 01:49:26PM +0100, Simon Vincent wrote:
...
> >>
> >>Try this . I hope it will work.
> >Sorry for the wrong info...
> >
> >Set up accept_redirects/send_redirects to boolean value '0'
> >
> >echo 0 > /proc/sys/net/ipv6/conf/all/accept_redirects
> >-- 
> I don't have a
> 
> /proc/sys/net/ipv6/conf/all/send_redirects
> 
> It looks like it is not possible to disable redirects on ipv6.

Do you have SYSFS enabled?

btw. Why we talking now about this... I think the issue is fixed by
dropping HOST_OTHERHOST in mac802154, but this handling is part of next
layer like 6LoWPAN(IPv6) or af802154.

- Alex
