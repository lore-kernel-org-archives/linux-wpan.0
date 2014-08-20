Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:48866 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbaHTXSV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:21 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so8589421wgg.24
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 0/8] initial commit of wpan-tools
Date: Thu, 21 Aug 2014 01:17:49 +0200
Message-Id: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this is just for review. I already apply these patches to the wpan-tools
repository. Some things are hacked like the version string, maybe we should
use some script to get git commit-id or make a real version.

It is a longer process to have a nice userspace tool. This is just the begin
to handle with the new cfg802154 interface.

The cfg802154 interface is available at [0], but needs some rebase work. I
will send them later. Sorry this will be a huge series of patches.

[0] https://github.com/linux-wpan/linux-wpan-next/tree/wpan_rework_rfc

- Alex

Alexander Aring (8):
  COPYING: add COPYING file
  initial commit
  gitignore: add gitignore files
  iwpan: fix coding style issue
  nl802154: update to current header file
  phy: initial commit for phy pib handling
  mac: initial commit for mac pib handling
  gitignore: add phy and mac object files

