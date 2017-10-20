Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:49513 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbdJTKWp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:45 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 4/7] uuid: Add IPSP UUID
Date: Fri, 20 Oct 2017 13:22:33 +0300
Message-Id: <20171020102236.17499-5-luiz.dentz@gmail.com>
In-Reply-To: <20171020102236.17499-1-luiz.dentz@gmail.com>
References: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds IPSP UUID in string format.
---
 lib/uuid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2c57a3378..71ed3df3b 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -81,6 +81,8 @@ extern "C" {
 #define SENSOR_LOCATION_UUID	"00002a5d-0000-1000-8000-00805f9b34fb"
 #define SC_CONTROL_POINT_UUID	"00002a55-0000-1000-8000-00805f9b34fb"
 
+#define IPSP_UUID		"00001820-0000-1000-8000-00805f9b34fb"
+
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
 
 #define HDP_UUID		"00001400-0000-1000-8000-00805f9b34fb"
-- 
2.13.6

