Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33671 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbAYPXa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 25 Jan 2015 10:23:30 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so5445472wiv.4
        for <linux-wpan@vger.kernel.org>; Sun, 25 Jan 2015 07:23:29 -0800 (PST)
Received: from omega (p20030064A953E167E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a953:e167:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id d7sm10547177wjs.2.2015.01.25.07.23.28
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 07:23:28 -0800 (PST)
Date: Sun, 25 Jan 2015 16:23:26 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: [ANNOUNCE] wpan-tools 0.4 released
Message-ID: <20150125152323.GB1059@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I'm happy to announce that I've just released wpan-tools 0.4.
This release contains cca handling and two cleanups. I will try to
do a new wpan-tools release each months.

You can get the release under:

http://wpan.cakelab.org/releases/

- Alex

Here is the shortlog about the changes in this release:

Alexander Aring (3):
      phy: sync cca handling with mainline
      interface: remove twice phy information
      info: remove unused features argument
