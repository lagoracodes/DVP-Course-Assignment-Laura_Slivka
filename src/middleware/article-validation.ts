import { z } from "zod";
import { Request, Response, NextFunction } from "express";

// article validation
const articleSchema = z.object({
  title: z
    .string()
    .min(5, "Title must be at least 5 characters")
    .max(150, "Title must not exceed 150 characters"),

  body: z
    .string()
    .min(50, "Article body must be at least 50 characters")
    .max(2500, "Article body must not exceed 2500 characters"),

  category: z
    .string()
    .min(3, "Category must be at least 3 characters")
    .max(50, "Category must not exceed 50 characters"),
});

export const validateArticle = (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const result = articleSchema.safeParse(req.body);

  if (!result.success) {
    return res.status(400).json({
      error: "Validation failed",
      details: result.error.issues.map((issue) => issue.message),
    });
  }
  next();
};

// partial article validation for patch
const partialArticleSchema = articleSchema.partial();

export const validatePartialArticle = (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const result = partialArticleSchema.safeParse(req.body);

  if (!result.success) {
    return res.status(400).json({
      error: "Validation failed",
      details: result.error.issues.map((issue) => issue.message),
    });
  }

  next();
};

// article id validation
const articleIdSchema = z.object({
  id: z.string().regex(/^[1-9]\d*$/, "Article ID must be a positive number"),
});

export const validateArticleId = (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const result = articleIdSchema.safeParse(req.params);

  if (!result.success) {
    return res.status(400).json({
      error: "Validation failed",
      details: result.error.issues.map((issue) => issue.message),
    });
  }

  next();
};
