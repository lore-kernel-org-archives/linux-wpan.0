Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33608 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbbFZLU3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Jun 2015 07:20:29 -0400
Received: by wgck11 with SMTP id k11so85946796wgc.0
        for <linux-wpan@vger.kernel.org>; Fri, 26 Jun 2015 04:20:27 -0700 (PDT)
Date: Fri, 26 Jun 2015 13:20:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150626112024.GC10816@omega>
References: <55831F48.4090905@osg.samsung.com>
 <55897C92.1060207@xsilon.com>
 <20150624100011.GA21293@omega>
 <20150624140111.GA12381@omega>
 <558D13C4.6000800@xsilon.com>
 <20150626093218.GA5074@omega>
 <558D1F3C.8050105@osg.samsung.com>
 <20150626095844.GA10816@omega>
 <558D2605.8080207@osg.samsung.com>
 <20150626102405.GB10816@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150626102405.GB10816@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

status update:

Phoebe meant do 1:1 what iptables does, this means:

1. Implement all interface cmds to iwpan.
2. The config file are only per line separated arguments of iwpan.
3. we implement a store/restore for that fileformat.

Okay this is much easier to implement and we should do that for the
first. I think that the order is important for setup such setting, so we
have internal dependencies which need to be setup at first. Then we need
to care about that.

At first a new file format is not necessary, later we can think about to
introduce such file format _maybe_ for a better handling.

This is just "Keep it simple and stupid" and (short, safe, whatever).

- Alex
