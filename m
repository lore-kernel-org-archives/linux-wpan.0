Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33605 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbbA1U5k (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 28 Jan 2015 15:57:40 -0500
Received: by mail-wi0-f171.google.com with SMTP id l15so15118029wiw.4
        for <linux-wpan@vger.kernel.org>; Wed, 28 Jan 2015 12:57:39 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 28 Jan 2015 15:27:10 +0530
Message-ID: <CAAkG1NMPUEg1jo=a84vndiScGQkox8SZHzRsVQ9EAP=-12sEag@mail.gmail.com>
Subject: Sample code for 6Lo tx/rx
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I was wondering if there is any example code that can tx/rx over a
6LoWPAN "node" interface. I've looked through the Unstrung code for
some examples but it uses ICMP all over. I'd really appreciate if
someone had any code samples for sending udp data over wpan. I tried
creating a SOCK_DGRAM socket over AF_IEEE802154 and got the "Protocol
not supported" error. Creating a SOCK_RAW worked but my life would be
much easier if I could start using DGRAMs :-) (One of the earlier
emails on the list mentioned DGRAMs over 6LoWPAN!).

Also, I've never used RAW sockets before, so any help with RAW sockets
over wpan (if DGRAM is not really an option) will also be a huge help!

Thanks!
-Rohit
