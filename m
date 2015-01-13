Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50729 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbAMLU0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Jan 2015 06:20:26 -0500
Received: by mail-wg0-f45.google.com with SMTP id y19so2291021wgg.4
        for <linux-wpan@vger.kernel.org>; Tue, 13 Jan 2015 03:20:25 -0800 (PST)
Received: from omega (p20030064A91100BCE2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a911:bc:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id f1sm25301078wjw.30.2015.01.13.03.20.24
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2015 03:20:24 -0800 (PST)
Date: Tue, 13 Jan 2015 12:20:19 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: 802.15.4 6LoWPAN fragmentation is broken
Message-ID: <20150113112016.GA14472@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I notice some issue with fragmentation code.

There is some magic number like:

ping6 2001::1 -s 2145

with a payload of 2144 it works. It seems that all payloads above
2144 are broken. I will try to bisect this issue. I see this issue also
in net-next. I suppose it's something with the inet_frag API.


... so don't worry I already working on it.

- Alex
